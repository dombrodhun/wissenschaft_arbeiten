# .latexmkrc
$pdf_mode = 4; # lualatex
$out_dir = 'build';
$lualatex = 'lualatex -interaction=nonstopmode -output-directory=%D %S';

# Biber für biblatex
add_cus_dep('bcf', 'blg', 0, 'biber_cus');
sub biber_cus {
  my ($base_name, $path) = fileparse(shift);
  my $return = system "biber", "$path/$base_name";
  return $return;
}

# Glossaries
add_cus_dep('glo', 'gls', 0, 'makeglossaries_cus');
add_cus_dep('acn', 'acr', 0, 'makeglossaries_cus');
sub makeglossaries_cus {
  my ($base_name, $path) = fileparse(shift);
  my $return = system "makeglossaries", "-d", $path, $base_name;
  return $return;
}
