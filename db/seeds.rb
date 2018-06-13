if Category.count == 0
  Category.create([
    {name: 'Asia'},
    {name: 'Africa'},
    {name: 'Europe'},
    {name: 'North America'},
    {name: 'South America'},
    {name: 'Oceania'},
    {name: 'University'},
    {name: 'Club'},
    {name: 'City'}
    ])
end