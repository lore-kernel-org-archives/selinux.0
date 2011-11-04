MIME-Version: 1.0
Date: Fri, 4 Nov 2011 11:16:22 +0100
Message-ID: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
Subject: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d044516fb398cfb04b0e5ff47
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044516fb398cfb04b0e5ff47
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am trying to get SELinux running on an Android phone. I did successfully
build the kernel with SELinux enabled and mounted selinuxfs on init. Now, I
would like to port SELinux user-space tools for policy loading/management.
I looked at sebusybox tool-set but ran into problems while compiling. My
hunch is that header files related to File System extended attributes are
missing in the bionic lib sources that Android builds on. Having said that
I have patched the Android YAFFS FS with an Xattr patch and also configured
the kernel accordingly.

I have sources of libselinux and libsepol checked out and am wondering how
to go about building these libraries for Android. Any help in this regard
would be much appreciated.

Regards,
Bhargava Shastry

--f46d044516fb398cfb04b0e5ff47
Content-Type: text/html; charset=ISO-8859-1

Hello,<br><br>I am trying to get SELinux running on an Android phone. I 
did successfully build the kernel with SELinux enabled and mounted 
selinuxfs on init. Now, I would like to port SELinux user-space tools 
for policy loading/management. I looked at sebusybox tool-set but ran 
into problems while compiling. My hunch is that header files related to 
File System extended attributes are missing in the bionic lib sources that 
Android builds on. Having said that I have patched the Android YAFFS FS 
with an Xattr patch and also configured the kernel accordingly.<br>
<br>I have sources of libselinux and libsepol checked out and am 
wondering how to go about building these libraries for Android. Any help
 in this regard would be much appreciated.<br clear="all"><br>Regards,<br clear="all">Bhargava Shastry<br>

--f46d044516fb398cfb04b0e5ff47--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
