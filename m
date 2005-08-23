Date: Tue, 23 Aug 2005 10:59:55 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 4/6] libsepol: expand.c resource leaks
Message-ID: <20050823155955.GA305@sergelap.austin.ibm.com>
References: <20050822161037.GD4191@sergelap.austin.ibm.com> <1124803009.7874.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124803009.7874.25.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> Hmm...I also added:
> 	ebitmap_destroy(&stypes);
>         ebitmap_destroy(&ttypes);
> 	return -1;

Oops!

I did re-run Coverity, so this *must* have been reported within the
last set of errors (which I still haven't gotten to).

It also appears the

	ebitmap_init(&stypes);
	ebitmap_init(&ttypes);

at the top of copy_neverallow can be removed, as they are duplicated
in the subsequent expand_convert_type_set() calls.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
