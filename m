Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6NGunU010781
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 18:16:56 -0500
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6NGs8H015280
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 23:16:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: hkp port
Date: Wed, 7 Nov 2007 10:16:49 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200711070000.53780.russell@coker.com.au> <4730EAD6.1060409@redhat.com>
In-Reply-To: <4730EAD6.1060409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711071016.52022.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 November 2007 09:29, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > http://etbe.coker.com.au/2007/11/06/squid-and-se-linux/
> >
> > As described in the above URL I believe that port 11371 (for GPG key
> > transfer) needs to be labelled as http_port_t to permit GPG to use Squid.
>
> Why not just create a new type for this port
>
> network_port(pgpkeyserver, udp, 11371,s0, tcp,11371,s0)
>
> Then give connect access to apache and squid.

A quick probe of some servers revealed that three of them didn't completely 
implement the HTTP protocol (IE they weren't proper web servers) and a fourth 
was running pks_www (which apparently is a stand-alone daemon not typically 
run from a web server).

So it seems that it's not web servers used for this and therefore a new port 
type is justified.

Policy for a key server daemon would be good too, I'll write it if I get some 
spare time.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
