Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Firewall Policy
Date: Wed, 13 Mar 2002 00:37:46 +0100
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.LNX.4.44L.0203121837220.2181-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0203121837220.2181-100000@imladris.surriel.com>
MIME-Version: 1.0
Message-Id: <20020312233747.804105CC4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Mar 2002 22:38, Rik van Riel wrote:
> On Tue, 12 Mar 2002, Russell Coker wrote:
> > For my Debian packages I am going to use a separate type for
> > /etc/bind/secondary to allow named to write files to that directory but
> > not the other named config files.  No way do I want named writing to my
> > primary zone files!
>
> That's going to screw up dynamic DNS updates and is bound to
> piss off quite a few of your users. Better document it well ;)

Good point.

However with the current state of sample policy if you install SE Linux with 
the defaults you'll be lucky to have your machine boot...

With the way these things work we can't have a default policy any more 
restrictive than unix permissions (IE usefully restrictive) without breaking 
things for people who apply it blindly.  That's life.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
