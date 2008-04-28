Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3SIQ95d009567
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 14:26:09 -0400
Message-ID: <481616BF.8020102@tycho.nsa.gov>
Date: Mon, 28 Apr 2008 14:26:07 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: copy/paste policy patch
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
In-Reply-To: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> Here's a patch I'm using with an MLS version of glipper to give the 
> capability to check for dominance between copy and paste data 
> contexts. Hopefully some version of this can be upstreamed.

Hi, why did you reverse the two paste operations?  In my suggestion I 
had the "paste" bit meaning "unconditional paste" and 
"paste_after_confirm" meaning "allow paste only after the user confirms."

Having the confirmation dialog semantics built in to the plain old 
"paste" permission seems to me like it would be more confusing, and 
difficult to change later.


>
> --- serefpolicy-3.3.1/policy/flask/access_vectors       2008-04-08 
> 13:41:18.000000000 -0500
> +++ serefpolicy-3.3.1.new//policy/flask/access_vectors  2008-04-08 
> 13:35:43.000000000 -0500
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
> --- serefpolicy-3.3.1/policy/flask/security_classes     2008-04-08 
> 13:41:18.000000000 -0500
> +++ serefpolicy-3.3.1.new//policy/flask/security_classes        
> 2008-04-08 13:34:36.000000000 -0500
> @@ -114,5 +114,6 @@
>  class x_resource               # userspace
>  class x_event                  # userspace
>  class x_synthetic_event                # userspace
> +class x_application_data        # userspace
>  
>  # FLASK
> --- serefpolicy-3.3.1/policy/mls        2008-04-08 13:41:18.000000000 
> -0500
> +++ serefpolicy-3.3.1.new/policy/mls    2008-04-08 14:20:49.000000000 
> -0500
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
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
