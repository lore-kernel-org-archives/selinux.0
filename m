Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7R1qDre032175
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 21:52:13 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7R1qDXp006016
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 01:52:13 GMT
Received: by gxk5 with SMTP id 5so3641200gxk.18
        for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 18:52:13 -0700 (PDT)
Message-ID: <48B4B348.2080801@gmail.com>
Date: Tue, 26 Aug 2008 21:52:08 -0400
From: Ivan Gyurdiev <ivg231@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com> <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil> <48B41D0E.6060509@redhat.com>
In-Reply-To: <48B41D0E.6060509@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I'm a little unclear on what this is doing - can you clarify?
>>     
> This is clearing the existing seusers.final file, otherwise delete was
> not working.
>   
I think the previous code was doing more - it was merging the local file 
with the shipped base package file, like this:

    data = extract_file_from_policy_package( )
    write_file ( "seusers.final", data )
    if ( data != null ) {
        seusers.clear_cache()  // thereby forcing reload from 
seusers.final when cache() is called again (in merge_components)
    } else {
        seusers.clear()
    }

It's also doing this three times (once for fcontexts, once for seusers, 
once for seusers_extra).
The problem is that you're skipping the link_sandbox call, which builds 
the base package, containing this information.

Ivan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
