Date: Tue, 12 Mar 2002 18:38:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
To: Russell Coker <russell@coker.com.au>
Cc: Reino Wallin <reino@oribium.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Firewall Policy
In-Reply-To: <20020312111616.5EC06D16C@lyta.coker.com.au>
Message-ID: <Pine.LNX.4.44L.0203121837220.2181-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Mar 2002, Russell Coker wrote:

> For my Debian packages I am going to use a separate type for
> /etc/bind/secondary to allow named to write files to that directory but
> not the other named config files.  No way do I want named writing to my
> primary zone files!

That's going to screw up dynamic DNS updates and is bound to
piss off quite a few of your users. Better document it well ;)

cheers,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
