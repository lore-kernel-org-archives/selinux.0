Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tom <tom@lemuria.org>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1112027973.2914.98.camel@moss-spartans.epoch.ncsc.mil>
References: <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
	 <1112017584.1514.239.camel@cobra.ivg2.net>
	 <20050328160935.B28563@lemuria.org>
	 <1112022358.5811.47.camel@cobra.ivg2.net>
	 <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328174753.D29441@lemuria.org>
	 <1112025866.2914.88.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328182020.A29887@lemuria.org>
	 <1112027973.2914.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 00:01:06 -0500
Message-Id: <1112158866.1536.29.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How about

New Directory Structure (added to /skel, or whatever)
~/content - ROLE_content_t
~/content/desktop - ???
~/content/downloads - ROLE_untrusted_content_t
~/content/media - ROLE_media_content_t
~/content/documents - ROLE_documents_content_t
~/content/mail - ROLE_mail_content_t
~/content/export_web - ROLE_httpd_user_content_t
~/content/export_samba - ROLE_samba_share_t
~/content/export_p2p - ROLE_p2p_share_t

Desktop apps will be restricted to only access the appropriate one.
"Downloading" apps will be restricted to download to
untrusted_content_t. 

Now...how to move things to/from ~/content/downloads in a nice
user-friendly way? What context for desktop? What role will the desktop
play?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
