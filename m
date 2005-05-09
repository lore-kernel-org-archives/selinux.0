Subject: Re: [ PATCHES ] mozilla, gift, games, orbit, gconf, genhomedircon
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1115625128.7589.19.camel@localhost.localdomain>
References: <1115625128.7589.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 May 2005 07:40:40 -0400
Message-Id: <1115638840.9774.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 04-gconfd.diff - 
> introduce policy for GConf, and a gnome
> container domain that will be used to instantiate
> a lot of stuff in the future

There's two lines in here about untrusted_content_t in gift
that shouldn't be there - you can erase those...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
