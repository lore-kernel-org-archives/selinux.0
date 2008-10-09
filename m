Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99791jJ027945
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 03:09:01 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9977n8I016586
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 07:07:50 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m99791XO009382
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 03:09:01 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9978x62013378
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 03:09:00 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m9978w3s031994
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 03:08:59 -0400
Message-ID: <48EDAE09.8070903@redhat.com>
Date: Thu, 09 Oct 2008 17:08:57 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide drafts: Archiving Files with tar/star
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are the first few drafts of the "Archiving Files with 
tar/star" sections. Any comments and corrections are appreciated.

Thanks.

Archiving Files with tar

tar does not retain extended attributes by default. Since SELinux 
contexts are stored in extended attributes, contexts can be lost when 
archiving files. Use tar --selinux to create archives that retain contexts.

The following example demonstrates creating a Tar archive that retains 
SELinux contexts:

1. As the Linux root user, run the touch /var/www/html/file{1,2,3} 
command to create three files (file1, file2, and file3). These files 
inherit the httpd_sys_content_t type from the /var/www/html/ directory:

[example output from ls -Z /var/www/html/]

2. Run the cd /var/www/html/ command to change into the /var/www/html/ 
directory. Once in this directory, as the Linux root user, run the tar 
--selinux -cf test.tar file{1,2,3} command to create a Tar archive named 
test.tar.

3. As the Linux root user, run the mkdir /test command to create a new 
directory, and then, run the chmod 777 /test/ command to allow all users 
full-access to the /test/ directory.

# I don't know if this is a bad idea. I thought it would prevent running 
all steps as root (I used /var/www/html/ to 'simulate' real world, 
instead of using home directory).

4. Run the cp /var/www/html/test.tar /test/ command to copy the test.tar 
file in to the /test/ directory.

5. Run the cd /test/ command to change into the /test/ directory. Once 
in this directory, run the tar -xf test.tar command to extract the Tar 
archive.

6. Run the ls -lZ /test/ command to view the SELinux contexts. The 
httpd_sys_content_t type has been retained, rather than being changed to 
default_t, which would have happened had the --selinux not been used:

[example output from ls -Z /test/]

7. If the /test/ directory is no longer required, as the Linux root 
user, run the  rm -ri /test/ command to remove it, as well as all files 
in it.

Refer to the tar(1) manual page for further information about tar, such 
as the --xattrs option that retains all extended attributes.

The following section is the same example, but uses "star -xattr 
-H=exustar" instead of tar --selinux.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
