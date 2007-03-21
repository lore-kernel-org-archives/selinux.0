Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LHsGec026533
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 13:54:16 -0400
Received: from web86912.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2LHsCRY024294
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 17:54:13 GMT
Message-ID: <20070321175402.60015.qmail@web86912.mail.ukl.yahoo.com>
Date: Wed, 21 Mar 2007 17:54:02 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Kernel Panics, when start with amendments in SELInux Source Code
To: selinux@tycho.nsa.gov
In-Reply-To: <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi Every one,


I have made a change to the security server of the
SELinux to see the files, that it accesses and print
their names. But when the kernel re-boots after
compilation, it panics and says that "some thing is
accessing directly the hardware" and keep on saying
this, until, i disable the selinux at boot time.

The code is as follows added to the
security_compute_av

const unsigned char *filepathp;
	char filepathbuf[512];	
	unsigned long count;
	filepathp = (const unsigned char *)
	    d_path(testfile->f_dentry, testfile->f_vfsmnt,
filepathbuf, 512);
	if (filepathp < 0) {
		filepathp = testfile->f_dentry->d_name.name;
		count = testfile->f_dentry->d_name.len + 1;
		if (count > 512)
			count = 512;
	} else {
		count = strlen(filepathp);
	}
	printk("Hi, this is the name of the file being
accessed %s \n",filepathp);
	return 0;


The testfile object is set within the
fs/nami.c:file_permission() into to a global variable,
which is then accessed by the services.c via
linux/fs.h.



The intention is to get the file information
associated with particular inodes. If some body can
help me in sorting out this, i will be very thankful.

Best,
MA



		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
