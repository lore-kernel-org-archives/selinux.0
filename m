Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJq9gA009227
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:52:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJlKYP024083
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:47:21 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E146D3.60809@tresys.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <42E146D3.60809@tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 15:44:47 -0400
Message-Id: <1122061488.30783.14.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >No...an intermediate representation on the libsepol level,
> >as well as the libsemanage level. 
> >
> >  
> >
> we need to figure out what we need to store before we decide if we need 
> another policy representation.

Speaking of which... I'm duplicating your sepol_*_t records
almost one-to-one in the libsepol api. I don't see a way around 
that, however, because they are located in libsemanage.

> >Can you please rename the library, so I can send patches against it?
> >I tried to do this myself, but you didn't like my patch.
> >
> >  
> >
> It won't matter since the library doesn't currently match the proposed 
> API.

It does matter, because I can write patches against it, and not write
semod_ everywhere that I need to fix later.

>  Probably the best thing would be to write your user and port 
> management stuff against the new API and see if it actually works.

I can't see if actually works, because there is no library to test it
with. It used to work when it was in libselinux... I'm sure I'll have
to change it a bit to fit with your structure names, and your apis,
and your transaction processing.

> semanage_user_change(semanage_handle_t *, semanage_user_t *userdata, 
> char* key);
> it would totally replace the datum, no unioning or anything like that

If you're assuming character key, please assume character key in
the delete functions as well. I'm not against it, simply pointing out..

The drawback to not providing any more specific change functions 
to the caller, is that now you have to do a query and a change for
everything, even if all you're doing is adding information, and not
extracting any. That means two iterations in the flat file case...
but for the sake of simplicity and cleanness of API, maybe I'll agree.

However, not having a query function is just wrong, I disagree with
that.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
