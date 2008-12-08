Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB8KvJbo028231
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2008 15:57:19 -0500
Message-ID: <493D8A2C.3060605@tycho.nsa.gov>
Date: Mon, 08 Dec 2008 15:57:16 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: immutable X windows
References: <cadfc0e40812080809m54514b47x4e098f501f1bd09f@mail.gmail.com>
In-Reply-To: <cadfc0e40812080809m54514b47x4e098f501f1bd09f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> We've talked in the past about the need for immutable windows for
> desktop security banners and window security labels so what do you
> think is the best way forward on this subject? I'm guessing that X
> server changes would be required to support immutable windows so we'd
> need to get X.Org involved, right?
>   

I believe that immutable windows are possible without involving the
server, by using a compositing window manager such as compiz.

A compositing window manager uses the Composite extension to redirect
window contents into memory buffers, then draws the window contents to
the screen by itself.  Since the manager does all the drawing itself, it
could make an area immutable to other programs.

I have checked the compiz source and I am working on a compiz plugin to
demonstrate the concept.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
