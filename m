Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UF6fDo015172
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 10:06:42 -0500 (EST)
Received: from web31603.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2UF5Wo4026858
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 15:05:32 GMT
Message-ID: <20050330150525.90469.qmail@web31603.mail.mud.yahoo.com>
Date: Wed, 30 Mar 2005 07:05:24 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> How about
> 
> New Directory Structure (added to /skel, or
> whatever)
> ~/content - ROLE_content_t
> ...
> ~/content/export_p2p - ROLE_p2p_share_t
> 
> Desktop apps will be restricted to only access the
> appropriate one.
> "Downloading" apps will be restricted to download to
> untrusted_content_t. 

Am I the only one wary of a slippery slope here?


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
