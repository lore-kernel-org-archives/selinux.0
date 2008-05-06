Subject: Re: copy/paste policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <481900C9.40406@tycho.nsa.gov>
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
	 <1209386863.30483.44.camel@gorn.columbia.tresys.com>
	 <4816523B.4030905@tycho.nsa.gov>
	 <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
	 <481900C9.40406@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 06 May 2008 10:27:17 -0400
Message-Id: <1210084037.8276.28.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-04-30 at 19:29 -0400, Eamon Walsh wrote:
> Xavier Toth wrote:
> > Seems to me that paste mlsconstrain should be (l1 eq l2) and should be 
> > a mlsconstrain for paste_after_confirm which is (l1 domby l2).
> 
> Revised patch attached.

Merged.

> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
> Index: policy/flask/security_classes
> ===================================================================
> --- policy/flask/security_classes	(revision 2669)
> +++ policy/flask/security_classes	(working copy)
> @@ -114,5 +114,6 @@
>  class x_resource		# userspace
>  class x_event			# userspace
>  class x_synthetic_event		# userspace
> +class x_application_data	# userspace
>  
>  # FLASK
> Index: policy/flask/access_vectors
> ===================================================================
> --- policy/flask/access_vectors	(revision 2669)
> +++ policy/flask/access_vectors	(working copy)
> @@ -775,3 +775,10 @@
>  {
>  	recv
>  }
> +
> +class x_application_data
> +{
> +	paste
> +	paste_after_confirm
> +	copy
> +}
> Index: policy/mls
> ===================================================================
> --- policy/mls	(revision 2669)
> +++ policy/mls	(working copy)
> @@ -568,7 +568,19 @@
>  	 ( t1 == mlsxwinwrite ));
>  
> 
> +#
> +# MLS policy for the x_application_data class
> +#
>  
> +# the x_application_data "paste" ops (explicit single level)
> +mlsconstrain x_application_data { paste }
> +	( l1 eq l2 );
> +
> +# the x_application_data "paste_after_confirm" ops (downgrade permitted)
> +mlsconstrain x_application_data { paste_after_confirm }
> +	( l1 domby l2 );
> +
> +
>  #
>  # MLS policy for the pax class
>  #
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
