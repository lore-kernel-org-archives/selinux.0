Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JJhxne005373
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:43:59 -0400
Message-ID: <467831F9.1040607@redhat.com>
Date: Tue, 19 Jun 2007 15:43:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: jwcart2@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: problem setting the security context of directories vs files
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBF7FE@blums0008.bluelnk.net> <1182272762.2086.78.camel@moss-lions.epoch.ncsc.mil> <467810A5.3090306@redhat.com> <FB39F4E77226B448BC1388D3BE4E00CD01DBF82C@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBF82C@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> Is there a way to apply a context recursively to all subdirectories
> below a directory?
>
> For instance, I'd like to label all subdirectories below
> "/m2ds/import/stage" as system_u:object_r:import_dir_t:s0, without
> explicitly having to list each one (because I'm lazy)
>
>   
/m2ds/import/stage(/.*)?   gen_context(system_u:object_r:import_dir_t:s0)

Will get everything

/m2ds/import/stage(/.*)?  -d  gen_context(system_u:object_r:import_dir_t:s0)

Will get only directories.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
