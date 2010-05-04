Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o44EU7CJ003924
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2010 10:30:07 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o44ETVVx024038
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2010 14:29:31 GMT
Received: by vws13 with SMTP id 13so2678670vws.12
        for <selinux@tycho.nsa.gov>; Tue, 04 May 2010 07:30:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100503221146.8177.84024.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
	 <20100503221146.8177.84024.stgit@flek.lan>
Date: Tue, 4 May 2010 10:30:05 -0400
Message-ID: <z2z7e0fb38c1005040730i9918785n488181e55eafa994@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/6] selinux: Convert socket related access
	controls to use socket labels
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 3, 2010 at 6:11 PM, Paul Moore <paul.moore@hp.com> wrote:
> At present, the socket related access controls use a mix of inode and
> socket labels; while there should be no practical difference (they
> _should_ always be the same), it makes the code more confusing.  This
> patch attempts to convert all of the socket related access control
> points (with the exception of some of the inode/fd based controls) to
> use the socket's own label.  In the process, I also converted the
> socket_has_perm() function to take a 'sock' argument instead of a
> 'socket' since that was adding a bit more overhead in some cases.

Should it be renamed to sock_has_perm() then?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
