MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: file_contexts & labelling...
Date: Wed, 27 Jun 2007 18:56:07 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D03B138D9@de01exm68.ds.mot.com>
In-Reply-To: <1182790991.5636.87.camel@moss-spartans.epoch.ncsc.mil>
References: <20070625162622.42210.qmail@web51503.mail.re2.yahoo.com> <1182790991.5636.87.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Suppose I use the Fedora Core 6 *strict* policy as my base...

I get the following file_context files as part of it:

/etc/selinux/strict/modules/active/file_contexts
/etc/selinux/strict/modules/active/file_contexts.template
/etc/selinux/strict/contexts/files/file_contexts

Lets say on my Linux machine I have a few additional directories under /
e.g.  /data , /download

And I want to label these directories a particular way... e.g.   I want
to label /data  as var_t for example...

I modified the above three file_context files to achieve this, such that

When I do "restorecon -rF /data" , the /data directory gets labeled as
var_t .

The problem I have is that:

Any time I execute commands (e.g. semanage or semodule) to modify the
running selinux policy, ...  the above three files automatically revert
back to their original version, and the changes I made to them get lost
!

How can I create modified file_context files or any other appropriate
file(s), such that, my changes are retained and stay permanent... So
that anytime I later need to relabel my /data directory, the directory
gets labeled the way I want, and doesn't get assigned default_t  or
file_t  or unlabeled_t, etc.

Question #2
------------

If I have setup my Linux <-> SELinux login mappings such that a regular
Linux user ssh into the box and gets context  user:user_u:user_t    and
it generally works... 
But sometimes something in my policy is getting corrupted ?!? such that
the login mappings remain exactly the same as before, but for some
strange reason, that regular Linux user ssh into the Linux box, but gets
context
system_u:system_r:kernel_t

Where should I look to see whats breaking to cause this anomaly ?


Thanks as always for your great help  :-)

- Reza.
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
