Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VCUoIo002706
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 08:30:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4VCUntC017151
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 12:30:49 GMT
Subject: Re: pipefs issue
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov,
        "Jensen, Curtis R (US SSA)" <curtis.jensen@baesystems.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBEF78@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBEF78@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Thu, 31 May 2007 12:29:41 +0000
Message-Id: <1180614581.10995.138.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 18:23 -0700, Clarkson, Mike R (US SSA) wrote:
> I've got a java process running in the datalabeler_t domain at the s2
> mls level, which kicks off a c++ executable in the import_t domain. 
> 
> There appears to be some inter-process communication being set up using
> pipefs between the parent and child process which is causing mls
> constraint issues. I'm not familiar with pipefs and I'm not explicitly
> creating this communication, either linux or java is implicitly creating
> it for me.
> 
> Is this configurable so that I can prevent the pipefs from being
> created?

Unnamed pipes are created on pipefs.  My guess is that stdin/out/err are
being redirected through a pipe.

> Alternatively, can I satisfy the below AVC denial messages without
> giving the import_t domain mlsfilereadup privilege? I don't mind giving
> the datalabeler_t domain extra privileges like writedown or readup, but
> I don't want to give the import_t domain those kind of mls privileges.

You could dontaudit it.

dontaudit import_t datalabeler_t:fifo_file { read write };

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
