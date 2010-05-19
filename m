MIME-Version: 1.0
In-Reply-To: <4BF41DD1.1070608@tycho.nsa.gov>
References: <AANLkTinfrhS8r4gnc92Pmt78dQ080wlJEdH8qZjM0ZjK@mail.gmail.com>
	 <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
	 <4BF41DD1.1070608@tycho.nsa.gov>
Date: Wed, 19 May 2010 22:33:29 +0500
Message-ID: <AANLkTik0wo0NgaYAlJljhxrPrA3EVjYbX-GH1EYX4Waa@mail.gmail.com>
Subject: Re: Howto enable or disable clipboard with selinux?
From: Shaz <shazalive@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> You could deny access to the clipboard by labeling the PRIMARY,
> SECONDARY, and CLIPBOARD selections (in the x_contexts file) with a
> context that application domains don't have permissions to access.  But
> this will result in BadAccess X protocol errors being returned to the
> application, which will probably abort() as a result (the standard Xlib
> error handling method is to call abort).
>
> You could also polyinstantiate X selections, which would cause the
> clipboard to stop working unless the two parties (selection owner and
> ConvertSelection request issuer) have the exact same context.  But if
> you do this, be aware that there are other selections (besides the
> clipboard ones) that you will need to keep as single instances if you
> want things like D-Bus to work.  Finding and dealing with all of these
> is a topic of interest at the moment.
>
> An x_contexts file with the following "selections" section would
> implement the second option (the file is located in the contexts/
> directory of the SELinux policy configuration):
>
> #
> ##
> ### Rules for X Selections
> ##
> #
>
> # Put all your single-instance exceptions here
> selection @server=ibus                  system_u:object_r:xselection_t:s0
> selection _DBUS_*                       system_u:object_r:xselection_t:s0
>
> # Default fallback type, will polyinstantiate everything else
> poly_selection *                        system_u:object_r:xselection_t:s0
>

I am finding this difficult to follow ... plz suggest some background
reading, which is less time consuming.

-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
