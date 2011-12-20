Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBK4lj6U011328
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 23:47:45 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pBK4lhdb006231
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2011 04:47:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Justin Mattock <justinmattock@yahoo.com>
Subject: Re: [refpolicy] semodule segfaults with ubuntu
Date: Tue, 20 Dec 2011 15:47:33 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <1320681595.98236.YahooMailNeo@web114319.mail.gq1.yahoo.com> <1320764942.66095.YahooMailNeo@web114310.mail.gq1.yahoo.com> <1324356207.34656.YahooMailNeo@web114308.mail.gq1.yahoo.com>
In-Reply-To: <1324356207.34656.YahooMailNeo@web114308.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201112201547.33428.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Dec 2011, Justin Mattock <justinmattock@yahoo.com> wrote:
> hmm... this is odd I just finished with creating a systemd patch(RFC) will
> send it out after loading, but I cant seem to load due to a segfault like
> the above. system setup is simple: qemu with fedora 16 and Mainline
> policy. I am hitting this with my patch, as well as stock unpatched
> policy..
> 
> I will try a bisect on the policy to see if I can find the bad commit, as
> well as libc to see what/where things are going wrong. in the meantime I
> will send out my systemd patch in the matter if anybody wants to have a go
> at it.

Once again, this isn't a policy issue.

Please run the crashing program under gdb and report back to this list.  A 
SEGV in a program like semodule is a serious issue and needs to be fixed.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
