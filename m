Subject: sexattr and getxattr
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: sds@epoch.ncsc.mil, nsa <SELinux@tycho.nsa.gov>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Content-Type: text/plain
Message-Id: <1099341061.9527.11.camel@jsingh>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 02:01:01 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

I have some trouble with using inode->i_op->get/setxattrs ...

I used getxattr and setxattr from linux/fs.h (kernel 2.6.8 and ext3) to
get and set xattrs in the following manner -

getxattr from /home and set it to /var/home

ls -Zd /home /var/home
drwxr-xr-x+ root     root  system_u:object_r:home_root_t    /home/
drwxr-xr-x+ root     root  system_u:object_r:home_root_t    /var/home/

perfect till now .. but now when i try and create files inside /var/home
they get the "root:object_r:var_t" unlike /home where i get
"root:object_r:user_home_dir_t"  :-(

and on the contrary if i create /var/home and tag with "home_root_t"
using setfiles it works perfectly fine ... any clues 

I cant use user-space get/setxattr coz I am writing a overlay
file-system ... so ....

any suggestions ....

Jaspreet Singh




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
