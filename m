Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1EBJ0Rb003204
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 06:19:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1EBIxc3029445
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 11:18:59 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1EBIgR0029350 for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 11:18:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: [Fwd: Bug#231561: setfiles ignores patterns beginning with a meta-character]
Date: Sat, 14 Feb 2004 22:17:14 +1100
References: <1076747890.14035.3.camel@nexus.verbum.private>
In-Reply-To: <1076747890.14035.3.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402142217.15050.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 19:38, Colin Walters <walters@verbum.org> wrote:
> Hi,
>
> Here's a patch I got from a Debian user for setfiles.  It makes sense to
> me.  What do you think?

The first change means that "tmp - buf" will always be 0, therefore no stem 
will ever be recognised.  A quick test of labeling /lib on one of my machines 
showed this as making setfiles take 25.8s on my laptop instead of 0.8s.

The second change means that the first character regular expression will be 
found thus giving correct behavior.  Make the second change not the first and 
the user should be happy.

  * if there is no identifiable stem */
 int get_stem_from_spec(const char * const buf)
 {
-       const char *tmp = strchr(buf + 1, '/');
+       const char *tmp = strchr(buf, '/');
        const char *ind;
 
        if(!tmp)
                return 0;
 
-       for(ind = buf + 1; ind < tmp; ind++)
+       for(ind = buf; ind < tmp; ind++)
        {
                if(strchr(regex_chars, (int)*ind))
                        return 0;


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
