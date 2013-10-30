Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9UGAR8J005637
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2013 12:10:27 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 4E4B01A1A4
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2013 17:10:14 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J5yXXmdXuq8w for <selinux@tycho.nsa.gov>;
	Wed, 30 Oct 2013 17:10:08 +0100 (CET)
Received: from soldur.bigon.be (unknown [193.53.238.195])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 9670A1A00F
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2013 17:10:08 +0100 (CET)
Date: Wed, 30 Oct 2013 17:10:07 +0100
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Properly build the swig exception file even if the
 headers are missing
Message-ID: <20131030171007.15a26535@soldur.bigon.be>
In-Reply-To: <1369073925-4446-1-git-send-email-bigon@debian.org>
References: <1369073925-4446-1-git-send-email-bigon@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Since you are busy merging stuffs, could somebody have a look at this
patch please (aka ping message)?

Cheers

Laurent Bigonville

Le Mon, 20 May 2013 20:18:45 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :

> From: Laurent Bigonville <bigon@bigon.be>
> 
> During build if the headers are not installed in the system path, the
> generated swig exception (.i) file might be empty.
> ---
>  libselinux/src/exception.sh  | 2 +-
>  libsemanage/src/exception.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index c3e61a5..b7cff7e09 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -15,6 +15,6 @@ echo "
>  ;;
>  esac
>  }
> -gcc -x c -c - -aux-info temp.aux < ../include/selinux/selinux.h
> +gcc -x c -c -I../include - -aux-info temp.aux
> < ../include/selinux/selinux.h for i in `awk '/<stdin>.*extern int/
> { print $6 }' temp.aux`; do except $i ; done rm -f -- temp.aux -.o
> diff --git a/libsemanage/src/exception.sh
> b/libsemanage/src/exception.sh index 8693fb7..94619d2 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -9,6 +9,6 @@ echo "
>  }
>  "
>  }
> -gcc -x c -c - -aux-info temp.aux < ../include/semanage/semanage.h
> +gcc -x c -c -I../include - -aux-info temp.aux
> < ../include/semanage/semanage.h for i in `awk '/extern int/ { print
> $6 }' temp.aux`; do except $i ; done rm -f -- temp.aux -.o



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
