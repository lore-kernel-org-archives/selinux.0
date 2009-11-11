Date: Wed, 11 Nov 2009 11:56:16 -0500
Subject: Re: MCS read only cats
From: Chad Sellers <csellers@tresys.com>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        <SELinux@tycho.nsa.gov>
Message-ID: <C72056E1.AFD7E%csellers@tresys.com>
In-Reply-To: <20091103114530.GH1672@myhost.felk.cvut.cz>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/3/09 6:45 AM, "Michal Svoboda" <michal.svoboda@agents.felk.cvut.cz>
wrote:

> Hello,
> 
> I have been thinking of how to best implement a feature called read only
> categories. That is, if we have a file with say c2, then c2 folks would
> have full access (given by TE rules), but also there would be a category
> called r2 (or c512+2 = c514 or whatever), that would be given read only
> access to the file.
> 
> It seems to me that an implementation would ideally deal with a simple
> MLS constrain or constrain relaxation. The reference policy constrains
> file reading thus:
> 
> mlsconstrain file { read ioctl lock execute execute_no_trans }
>         (( h1 dom h2 ) or ( t1 == mcsreadall ) or ( t2 == domain ));
> 
> How would one say 'also allow rN if file is cN'? So far I only came up
> with an enumeration like so:
> 
>            (h1 dom r0 and h2 == c0)
> or (h1 dom r1 and h2 == c1)
> or (...1022 more)
> 
> Which seems ugly and perhaps such a mammoth expression would hog the
> system too much. Moreover it seems it would be very difficult to
> accomodate this enumeration for h2 == { c0, c1 } and beyond.
> 
Michal,

You probably didn't get any responses because no one has a good idea of how
you could do this. The MLS engine (which is what powers MCS) was not
designed to do what you have in mind.

You're plan above will not work because you cannot express the constraints
as you've written them. You cannot single out specific categories in
mlsconstrain statements as you've tried to do. You are limited to
expressions about the high and low portions of the MLS field as a whole.

I'm sorry I don't know of a good way to accomplish what you're looking for.
You might be able to do something similar with a large enumeration in TE,
but that doesn't sound like what you're looking for. Perhaps someone else
will think of a creative way to use the MLS engine to do what you want, but
I don't know of one.

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
