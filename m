Subject: Re: copy/paste policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40805281018g954170et2bb00a87039e780f@mail.gmail.com>
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
	 <1209386863.30483.44.camel@gorn.columbia.tresys.com>
	 <4816523B.4030905@tycho.nsa.gov>
	 <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
	 <481900C9.40406@tycho.nsa.gov> <1210084037.8276.28.camel@gorn>
	 <cadfc0e40805281018g954170et2bb00a87039e780f@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 May 2008 14:21:49 -0400
Message-Id: <1211998909.5008.140.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-28 at 12:18 -0500, Xavier Toth wrote:
> Here's what I've actually ended up using to allow pasting equal or up
> without requiring confirmation and to require confirmation when
> attempting to paste down:
> 
> Index: policy/mls
> ===================================================================
> --- policy/mls	(revision 2704)
> +++ policy/mls	(working copy)
> @@ -574,11 +574,11 @@
> 
>  # the x_application_data "paste" ops (explicit single level)
>  mlsconstrain x_application_data { paste }
> -	( l1 eq l2 );
> +	(( l1 eq l2 ) or ( l1 domby l2 ));

Isn't the (l1 eq l2) redundant?

>  # the x_application_data "paste_after_confirm" ops (downgrade permitted)
>  mlsconstrain x_application_data { paste_after_confirm }
> -	( l1 domby l2 );
> +	( l1 dom l2 );
> 
> 
>  #
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
