From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joe Nall <joe@nall.com>
Subject: Re: window manager policy
Date: Fri, 20 Jun 2008 19:50:31 +1000
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Xavier Toth <txtoth@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
References: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com> <4859A64C.7050705@tycho.nsa.gov> <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com>
In-Reply-To: <77033ABC-28F3-451A-8400-7AB50FDC929F@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806201950.41120.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 20 June 2008 09:12, Joe Nall <joe@nall.com> wrote:
> What other desktop related processes need MLS policies to be written  
> to get a minimally functional Fedora/Gnome enforcing X environment?

The clipboard manager.  But of course that also needs some serious coding to 
preserve the labels on copied data as well as relabelling it if requested and 
permitted.

Of course it may be a matter of opinion whether functional cut/paste 
is "minimal" desktop use.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
