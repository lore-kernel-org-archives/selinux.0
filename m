Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8A788o0009448
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 03:08:08 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8A77hVY016013
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 07:07:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
Date: Sun, 10 Sep 2006 17:08:00 +1000
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
References: <44FFEB42.90203@kaigai.gr.jp> <45039AC2.3040309@kaigai.gr.jp>
In-Reply-To: <45039AC2.3040309@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200609101708.03454.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 10 September 2006 14:55, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> In recent days, I'm making a plan to enhance PostgreSQL with SELinux.
> I posted the first draft of this plan a few days ago, and I got many
> response. Thanks for your comments so much.
> (Especially, Joshua and Russell)

Firstly, I didn't notice any getattr permission...

> - delete a row
> Becaues the delete opetation involves the whole of one row, column:delete
> is not evaluated when we try to delete a row.
> (Thus, it's not defined.)
> This behavior may be a bit controvertible.

Maybe the column object class could have an entry deletefrom which allows 
deleting a row that has an entry in that column.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
