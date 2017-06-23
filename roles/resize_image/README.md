# Ansible Role: Resize Image


This role help resize an image to specific size. Basically, it uses ImageMagick package --size option.


## Example Playbook
~~~
 - name: Resize Image
   hosts: master1.example.com
   gather_facts: false

   roles:
   - { role: resize_image, input_img: "/etc/origin/master/stylesheet/images/logo-long.png", output_img: "logo-long-resized.png", size: "193x44" }
~~~
## License

Licensed under the Apache License, Version 2.0

## Author Information

This role was created in 2016 by [Jooho Lee](http://github.com/jooho).
