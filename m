Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBP1uBIi010174
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 20:56:12 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBP1sPbn019529
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 01:54:25 GMT
Received: by wproxy.gmail.com with SMTP id 37so132124wra
        for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 17:56:15 -0800 (PST)
Message-ID: <4c4ba15304122417561d8310e7@mail.gmail.com>
Date: Fri, 24 Dec 2004 17:56:15 -0800
From: Tom London <selinux@gmail.com>
Reply-To: Tom London <selinux@gmail.com>
To: russell@coker.com.au
Subject: Re: adds for latest policy...cups.te, udev.te?
Cc: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200412251231.44388.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4c4ba153041224120017763d5a@mail.gmail.com>
	 <200412251231.44388.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Dec 2004 12:31:40 +1100, Russell Coker <russell@coker.com.au> wrote:
> On Saturday 25 December 2004 07:00, Tom London <selinux@gmail.com> wrote:
> 
> can_network_server_tcp(cupsd_config_t)
> It looks like we need to change the above to the below:
> can_network_tcp(cupsd_config_t)
> 
> Also I suggest the change in the attached file net.diff to remove redundancy
> in the policy.conf file.
> 
> The attached patch udev.diff (which I sent to the SE Linux mailing list at
> about the same time as your message was posted) should fix this.
> 
> We could have done that.  But I think that pam_console_apply should run in
> domain pam_console_t when launched by udev.
> 
> --

Russell,

Thanks.  These work.

tom

-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
