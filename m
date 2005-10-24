Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9OFGnNs007836
	for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2005 11:16:49 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9OFCnjX007115
	for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2005 15:12:49 GMT
Message-ID: <435CFA2C.8090404@redhat.com>
Date: Mon, 24 Oct 2005 11:13:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: pegasus
References: <1130017523.10739.83.camel@sgc.columbia.tresys.com>
In-Reply-To: <1130017523.10739.83.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> While converting the pegasus policy over to reference policy, I came
> across this peculiar use types and rules:
>
> type pegasus_conf_exec_t, file_type, exec_type, sysadmfile;
>
> rw_dir_create_file(pegasus_conf_exec_t, pegasus_conf_t)
>
> This is the only use of pegasus_conf_exec_t, and is obvious that it
> doesn't have an effect.  There is a pegasus_conf_t, but it also is a
> file_type, used for the configuration files.  My guess is that the
> original intention was to make a domain for pegasus configuration
> programs, but it went awry.
>
>   
Yes, I am going to meet with the developer of the policy and see what he 
intended.  For now I would eliminate them from policy.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
