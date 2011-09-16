Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G4nl9r018697
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 00:49:48 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G4nkpQ009369
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 04:49:47 GMT
Subject: Re: [PATCH 35/67] policycoreutils: sandbox: FIXME add level based
 kill
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 06:49:37 +0200
In-Reply-To: <4E7255EB.3000804@redhat.com>
References: <4E7255EB.3000804@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316148577.2364.28.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 15:45 -0400, Daniel J Walsh wrote:
> @@ -941,6 +1011,9 @@ childerr:
>         waitpid(child, &status, 0);
>         status_to_retval(status, status);
>  
> +       if (execcon && kill_all)
> +               killall(execcon);
> +
>         if (tmpdir_r) cleanup_tmpdir(tmpdir_r, tmpdir_s, pwd, 1);
>  
>  err: 

Was it not just "kill" instead of "kill_all" ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
