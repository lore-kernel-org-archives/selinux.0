Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KIRDgA019062
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 14:27:13 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KILx9b014344
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 18:22:00 GMT
Message-ID: <42DE9657.8010504@tresys.com>
Date: Wed, 20 Jul 2005 14:22:15 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: Patch: rename semod
References: <1121803264.7252.24.camel@celtics.boston.redhat.com>
In-Reply-To: <1121803264.7252.24.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>The following patch renames all occurences of semod to semanage.
>It's zipped and large, because it renames the folder too. You can
>re-diff the old libsemod against libsemanage to verify contents.
>
>semod_ -> semanage_ : everywhere, automated replace
>  
>
>semod  -> semanage : everywhere, manual replace
>  
>
>SEMOD -> SEMANAGE : everywhere, manual replace
>
>  
>
This isn't correct, not all symbols will be changed as some have to do 
with modules exclusively (and are internal)

>semodule -> not replaced
>
>Diff is against selinux-usr folder in CVS, and
>affects multiple programs.
>
>Haven't verified correctness of automated replace beyond
>checking if everything compiles (which it does).
>  
>
I'll be sending a patch that implements the API we discussed here and 
does all the necessary changes that applies against cvs sometime soon.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
