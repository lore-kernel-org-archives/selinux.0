Subject: Re: copy/paste policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 08:47:43 -0400
Message-Id: <1209386863.30483.44.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-04-25 at 08:07 -0500, Xavier Toth wrote:
> Here's a patch I'm using with an MLS version of glipper to give the
> capability to check for dominance between copy and paste data
> contexts. Hopefully some version of this can be upstreamed.

Is the code on its way to being upstreamed?

> --- serefpolicy-3.3.1/policy/flask/access_vectors       2008-04-08 13:41:18.000000000 -0500
> +++ serefpolicy-3.3.1.new//policy/flask/access_vectors  2008-04-08 13:35:43.000000000 -0500
> @@ -765,3 +765,10 @@
>  {
>         recv
>  }
> +
> +class x_application_data 
> +{
> +        paste
> +        paste_without_confirm
> +        copy
> +}
> --- serefpolicy-3.3.1/policy/flask/security_classes     2008-04-08 13:41:18.000000000 -0500
> +++ serefpolicy-3.3.1.new//policy/flask/security_classes        2008-04-08 13:34:36.000000000 -0500
> @@ -114,5 +114,6 @@
>  class x_resource               # userspace
>  class x_event                  # userspace
>  class x_synthetic_event                # userspace
> +class x_application_data        # userspace
>  
>  # FLASK
> --- serefpolicy-3.3.1/policy/mls        2008-04-08 13:41:18.000000000 -0500
> +++ serefpolicy-3.3.1.new/policy/mls    2008-04-08 14:20:49.000000000 -0500
> @@ -567,6 +567,12 @@
>          ( t1 == mlsxwinwritexinput ) or
>          ( t1 == mlsxwinwrite ));
>  
> +#
> +# MLS policy for the x_application_data class
> +#
> +mlsconstrain x_application_data { paste_without_confirm }
> +       ( l1 domby l2 );
> +
>  
>  #
>  # MLS policy for the pax class
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
