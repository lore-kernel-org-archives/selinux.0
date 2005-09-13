Message-ID: <43272C09.3050105@trustedcs.com>
Date: Tue, 13 Sep 2005 14:44:09 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New ideas on implementation on libsetrans.
References: <43271BDA.3060403@redhat.com>
In-Reply-To: <43271BDA.3060403@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> After some discussion, we want to change the translation library into a 
> long running daemon with a unix domain socket that libselinux can talk 
> to for translation.  This eliminates the need to use dlopen, and link 
> with -dl.
> Dan
> 

I mentioned the idea of socket communications when I initially presented
the translation framework patch.  My comment was that imposing a mechanism
like that that on all translators may be a little much.  The use of the
dlopen'd library make it easy for someone to use flat files, UDS, TCP...
Our current translation library is actually just a "communication manager"
that talks via UDS to a daemon process which manages the labels.

There is an upshot to using UDS in libselinux - it makes the policy for all
users of libselinux generic.  The callers of libselinux functions only need
to be able to use the socket.  Currently, differing translators could require
different access rights for libselinux users.  In the socket scheme, only the
daemon needs the "specific" access rights to do the translations - that is
much easier to manage.

I like the earlier idea on libsetrans about choosing a library based off
of the policy type.  Would something similar be considered here (like
/var/setrans/mls, /var/setrans/targeted, etc., where all of the sockets
share the same type)?

Have you put any thought into the language that libselinux and the daemons
would speak over the socket?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
