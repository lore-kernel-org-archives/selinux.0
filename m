Message-ID: <20050112001948.21459.qmail@web50206.mail.yahoo.com>
Date: Tue, 11 Jan 2005 16:19:48 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Added is_context_configurable function
To: Colin Walters <walters@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1105481440.24748.22.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Colin Walters <walters@redhat.com> wrote:
 
> I feel that the 
> on-disk version should be canonical, and the
> file_contexts only used for
> system initialization.

I'd have to recheck the LSPP spec, but the B1
requirements clearly stated that MAC labels
had to be stored on the same media as the files.
The "closer" the MAC attribute is to the file,
the better. Hence an attribute of the file with
the MAC label is prefered to a file or database.
Further, the attribute must be associated with
the file, not a pathname. Files can exist, after
all, without a pathname.


=====
Casey Schaufler
casey@schaufler-ca.com


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
