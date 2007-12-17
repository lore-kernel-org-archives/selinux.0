Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBHN4k0W028365
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 18:04:46 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBHN4j46001189
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 23:04:45 GMT
Received: by fg-out-1718.google.com with SMTP id 16so305640fgg.40
        for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 15:04:42 -0800 (PST)
Message-ID: <cadfc0e40712171504t307640a3lab4e8b3b6ada502e@mail.gmail.com>
Date: Mon, 17 Dec 2007 17:04:42 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: [Fwd: f8 X policy]
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1197924309.12626.270.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4766D524.6090702@tycho.nsa.gov> <1197922696.12626.263.camel@gorn>
	 <1197923561.17307.134.camel@moss-spartans.epoch.ncsc.mil>
	 <1197924309.12626.270.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is what I've been playing with so far to get some of our X
applications to run without any X related avcs. This is not meant to
be a real solution just one to get an idea of the scope of the problem
and to hopefully get other thinking about it. The newrole_t stuff is
because I'm using newrole to run these apps at level.

# X
gen_require(`type xdm_xserver_t, user_t;');
mls_socket_read_all_levels(xdm_xserver_t)
mls_socket_write_all_levels(xdm_xserver_t)
allow xdm_xserver_t security_t:file { read write };
allow xdm_xserver_t security_t:security { compute_create compute_av };
allow xdm_xserver_t user_t:dir { search };
allow xdm_xserver_t user_t:file { read };
allow xdm_xserver_t self:netlink_selinux_socket { read };
mls_file_read_all_levels(xdm_xserver_t)
mls_file_write_within_range(xdm_xserver_t)

gen_require(`type xdm_tmp_t;');
mls_trusted_object(xdm_tmp_t)
allow user_t xdm_tmp_t:lnk_file { read };

gen_require(`type newrole_t;');
allow newrole_t xdm_tmp_t:sock_file { getattr write };
allow newrole_t xdm_tmp_t:file { read getattr };


On Dec 17, 2007 2:45 PM, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
>
> On Mon, 2007-12-17 at 15:32 -0500, Stephen Smalley wrote:
> > On Mon, 2007-12-17 at 15:18 -0500, Christopher J. PeBenito wrote:
> > > On Mon, 2007-12-17 at 14:59 -0500, Eamon Walsh wrote:
> > > > -------- Original Message --------
> > > > Subject:  f8 X policy
> > > > Date:     Mon, 17 Dec 2007 13:37:54 -0600
> > > > From:     Xavier Toth <txtoth@gmail.com>
> > > > To:       Eamon Walsh <ewalsh@tycho.nsa.gov>
> > > >
> > > >
> > > >
> > > > I'm starting to look more closely at X related avcs and have some
> > > > questions related to file contexts. Looking at the xserver.fc I see
> > > > that there are defaults for tmp files and directories with level s0.
> > > > So when clients at level try to write X0 avcs like:
> > > >
> > > > type=AVC msg=audit(1197913061.254:3125): avc:  denied  { write } for
> > > > pid=15405 comm="QBrowser" name="X0" dev=dm-0 ino=25853956
> > > > scontext=user_u:user_r:user_t:s2:c0.c254
> > > > tcontext=system_u:object_r:xdm_tmp_t:s0 tclass=sock_file
> > > >
> > > > occur. I'm thinking this is an mls constraint violation and I'm trying
> > > > to figure out how to deal with it. What do you think?
> > >
> > > It is indeed a MLS denial, so the options would be:
> > >
> > > 1. make xdm_tmp_t ranged
> > > 2. make xdm_tmp_t a trusted object
> > >
> > > The more I look at it, the more they look like the same option.
> > > Opinions?
> >
> > Can we get a discrete type applied to that socket file that is not used
> > for any other file?  So that we are only making that socket a MLS
> > trusted object and no other /tmp file created by X?
>
> Yes, I that is another option.  Only seems useful in the MLS policy
> though.  We could add a xdm_socket_t that is an alias of xdm_tmp_t in
> the standard (TE-only) or mcs configs.  Or is there a reason to keep it
> separate in all cases?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
