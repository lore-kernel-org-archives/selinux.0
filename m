Subject: Overlay Filesystem and SELinux
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Colin Walters <walters@verbum.org>, sds@epoch.ncsc.mil
Cc: nsa <SELinux@tycho.nsa.gov>, Philip Leo <phlpleo@yahoo.com>
In-Reply-To: <20041020174938.GL21185@lkcl.net>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com>
	 <20041020151031.GB21185@lkcl.net>  <20041020174938.GL21185@lkcl.net>
Content-Type: text/plain
Message-Id: <1098887565.1620.15.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 20:02:45 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi , 

Thanx for the help .. so far so good I am on track with my
"Virtualization and SELinux" ;-)

I am trying to implement a overlay-fs with selinux and got struck in a
problem.

Overlay-fs (for those who are unaware) virtually lets to write to a
read-only fs. like if you say ...

mount -t overlay -o dir1=/base,dir2=/storage /base /target

so all the efforts to write base are directed towards the storage. So if
i try and write to a writable-file in base say 

/target/etc/httpd/conf then the new file would be created in the storage
with complete path till that file ... so the initially empty storage
will have /storage/etc/httpd/conf.

But the problem is the newly created directory /storage/etc inherits
security context from /storage :-)

I know this was expected .. but is there any way to override it so that
.... a new directories and files (etc var etc) inside the storage gets
tagged with specific context like etc_t and var_t.

type_transition can only help putting same tag on all etc/ and var/ as
there is same kernel_t process creating them.

second thing possible is .. if i create skeleton directories inside
storage and tag them properly.

What do you say...
Thanx
Jaspreet


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
