Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03KTOsZ029237
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 15:29:24 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m03KTNNN010526
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 20:29:24 GMT
Subject: Re: mls policy dbus patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40712281328m7f13fe70i7b9fdbfca9f19606@mail.gmail.com>
References: <cadfc0e40712281328m7f13fe70i7b9fdbfca9f19606@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 15:28:22 -0500
Message-Id: <1199392102.12626.323.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-12-28 at 15:28 -0600, Xavier Toth wrote:
> --- serefpolicy-3.0.8/policy/mls        2007-11-27 14:43:26.000000000 -0600
> +++ serefpolicy-3.0.8.new/policy/mls    2007-12-21 14:38:52.000000000 -0600
> @@ -584,7 +584,11 @@
>  #
> 
>  # these access vectors have no MLS restrictions
> -# dbus { acquire_svc send_msg }
> +# dbus { acquire_svc }
> +mlsconstrain dbus { send_msg }
> +        (( l1 eq l2 ) or
> +         ( t1 == mlsdbussend ) or
> +         ( t2 == mlsdbusrecv ));
> 
> 
> 
> --- serefpolicy-3.0.8/policy/modules/kernel/mls.te      2007-11-27
> 14:43:26.000000000 -0600
> +++ serefpolicy-3.0.8.new/policy/modules/kernel/mls.te  2007-12-21
> 14:35:30.000000000 -0600
> @@ -61,3 +61,6 @@
>  attribute mlsfdshare;
> 
>  attribute mlstranslate;
> +
> +attribute mlsdbusrecv;
> +attribute mlsdbussend;
> --- serefpolicy-3.0.8/policy/modules/kernel/mls.if      2007-11-27
> 14:43:26.000000000 -0600
> +++ serefpolicy-3.0.8.new/policy/modules/kernel/mls.if  2007-12-21
> 14:37:31.000000000 -0600
> @@ -859,3 +859,42 @@
> 
>         typeattribute $1 mlsdbdowngrade;
>  ')
> +########################################
> +## <summary>
> +##      Make specified domain MLS trusted
> +##      for send to dbus.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_dbus_send',`
> +       gen_require(`
> +               attribute mlsdbussend;
> +       ')
> +
> +       typeattribute $1 mlsdbussend;
> +')
> +
> +########################################
> +## <summary>
> +##      Make specified domain MLS trusted
> +##      for receiving from dbus.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_dbus_recv',`
> +       gen_require(`
> +               attribute mlsdbusrecv;
> +       ')
> +
> +       typeattribute $1 mlsdbusrecv;
> +')

Merged, with a few adjustments to the interface names.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
