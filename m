Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBHMAVoH022065
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 17:10:31 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBHMAU46012362
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 22:10:30 GMT
Received: by py-out-1112.google.com with SMTP id u77so5004944pyb.15
        for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 14:10:29 -0800 (PST)
Message-ID: <4766F344.6040404@gmail.com>
Date: Mon, 17 Dec 2007 16:08:04 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: Re: [Fwd: f8 X policy]]
Content-Type: multipart/mixed;
 boundary="------------060808000101000608070608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060808000101000608070608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry I should have put this on the list.

--------------060808000101000608070608
Content-Type: message/rfc822;
 name="Re: [Fwd: f8 X policy].eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Fwd: f8 X policy].eml"

X-Account-Key: account2
X-Mozilla-Keys: 
Delivered-To: txtoth@gmail.com
Received: by 10.86.9.12 with SMTP id 12cs183456fgi;
        Mon, 17 Dec 2007 12:45:45 -0800 (PST)
Received: by 10.143.121.5 with SMTP id y5mr1486147wfm.223.1197924344334;
        Mon, 17 Dec 2007 12:45:44 -0800 (PST)
Return-Path: <cpebenito@tresys.com>
Received: from exchange.columbia.tresys.com (exchange.columbia.tresys.com [216.250.243.126])
        by mx.google.com with SMTP id h14si5362440wxd.2007.12.17.12.45.42;
        Mon, 17 Dec 2007 12:45:44 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of cpebenito@tresys.com designates 216.250.243.126 as permitted sender) client-ip=216.250.243.126;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of cpebenito@tresys.com designates 216.250.243.126 as permitted sender) smtp.mail=cpebenito@tresys.com
Received: from 10.1.13.190 ([10.1.13.190]) by exchange.columbia.tresys.com ([192.168.243.126]) with Microsoft Exchange Server HTTP-DAV ;
 Mon, 17 Dec 2007 20:45:42 +0000
Received: from gorn by exchange.columbia.tresys.com; 17 Dec 2007 15:45:09 -0500
Subject: Re: [Fwd: f8 X policy]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>
In-Reply-To: <1197923561.17307.134.camel@moss-spartans.epoch.ncsc.mil>
References: <4766D524.6090702@tycho.nsa.gov>
	 <1197922696.12626.263.camel@gorn>
	 <1197923561.17307.134.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Tresys Technology, LLC
Date: Mon, 17 Dec 2007 15:45:09 -0500
Message-Id: <1197924309.12626.270.camel@gorn>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.2 

On Mon, 2007-12-17 at 15:32 -0500, Stephen Smalley wrote:
> On Mon, 2007-12-17 at 15:18 -0500, Christopher J. PeBenito wrote:
> > On Mon, 2007-12-17 at 14:59 -0500, Eamon Walsh wrote:
> > > -------- Original Message --------
> > > Subject: 	f8 X policy
> > > Date: 	Mon, 17 Dec 2007 13:37:54 -0600
> > > From: 	Xavier Toth <txtoth@gmail.com>
> > > To: 	Eamon Walsh <ewalsh@tycho.nsa.gov>
> > > 
> > > 
> > > 
> > > I'm starting to look more closely at X related avcs and have some
> > > questions related to file contexts. Looking at the xserver.fc I see
> > > that there are defaults for tmp files and directories with level s0.
> > > So when clients at level try to write X0 avcs like:
> > > 
> > > type=AVC msg=audit(1197913061.254:3125): avc:  denied  { write } for
> > > pid=15405 comm="QBrowser" name="X0" dev=dm-0 ino=25853956
> > > scontext=user_u:user_r:user_t:s2:c0.c254
> > > tcontext=system_u:object_r:xdm_tmp_t:s0 tclass=sock_file
> > > 
> > > occur. I'm thinking this is an mls constraint violation and I'm trying
> > > to figure out how to deal with it. What do you think?
> > 
> > It is indeed a MLS denial, so the options would be:
> > 
> > 1. make xdm_tmp_t ranged
> > 2. make xdm_tmp_t a trusted object
> > 
> > The more I look at it, the more they look like the same option.
> > Opinions?
> 
> Can we get a discrete type applied to that socket file that is not used
> for any other file?  So that we are only making that socket a MLS
> trusted object and no other /tmp file created by X?

Yes, I that is another option.  Only seems useful in the MLS policy
though.  We could add a xdm_socket_t that is an alias of xdm_tmp_t in
the standard (TE-only) or mcs configs.  Or is there a reason to keep it
separate in all cases?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--------------060808000101000608070608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
