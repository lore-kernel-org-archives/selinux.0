Message-ID: <20041111185628.79458.qmail@web50601.mail.yahoo.com>
Date: Thu, 11 Nov 2004 10:56:28 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: How come security_get_boolean_pending returns true when a boolean is on.
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <419373C8.8050701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Shouldn't this be
>staff_read_sysadm_file --> active: 1 pending: 0

That depends....SE Linux interface remembers booleans that get set but haven't
been committed. There isn't an explicit "rollback" command to match the commit. I
tried to fix togglesebool and setsebool to do a rollback by walking the table and
setting all pending values to the active value.

We you using current tools and how did you get it like that?

-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
