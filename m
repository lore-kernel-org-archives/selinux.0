Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9NJrWFd019057
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 15:53:32 -0400
Received: by mail-we0-f181.google.com with SMTP id u54so2730265wey.12
        for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 12:52:57 -0700 (PDT)
Message-ID: <1351021973.2774.2.camel@d30.localdomain>
Subject: Re: Question about policy module error message
From: Dominick Grift <dominick.grift@gmail.com>
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 23 Oct 2012 21:52:53 +0200
In-Reply-To: <CCAC6810.2205%thomas.moyer@ll.mit.edu>
References: <CCAC6810.2205%thomas.moyer@ll.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Tue, 2012-10-23 at 15:28 -0400, Moyer, Thomas - 0668 - MITLL wrote:
> I am trying to build an SELinux policy module for a piece of software
> I am writing. I used sepolgen to create an initial skeleton policy
> (running on Red Hat Enterprise Linux 6). I get the following error
> when I try and install the policy:
> 
> 
> sudo ./interface.sh
> Building and Loading Policy
> + make -f /usr/share/selinux/devel/Makefile
> make: Nothing to be done for `all'.
> + /usr/sbin/semodule -i interface.pp
> libsemanage.semanage_fc_sort: WARNING: semanage_fc_sort: Incomplete
> context.
> libsepol.sepol_context_from_string: malformed context "dnl"
> libsepol.sepol_context_from_string: could not construct context from
> string
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert dnl to sid
> invalid context dnl
> libsemanage.semanage_install_active: setfiles returned error code 1.
> /usr/sbin/semodule:  Failed!
> 
> 
> Below is the interface.fc file since I think the error might be in
> there.
> /usr/local/bin/interface --
> gen_context(system_u:object_r:interface_exec_t,s0)
> /usr/local/libexec/interface gen_context(system_u:object_r:usr_t,s0)
> /usr/local/libexec/interface/WebApp.jar --
> gen_context(system_u:object_r:httpd_sys_content_t,s0)
> /usr/local/libexec/interface/keystore --
> gen_context(system_u:object_r:interfaceKey_t,s0)
> /usr/local/libexec/interface/ui-files(/.*)?
> gen_context(system_u:object_r:httpd_sys_content_t,s0)
> 

Maybe "interface" is a keyword. Could you try another name for the sake
of testing?

The .fc contents look OK to me.

Also make sure that the .fc has a newline at the end ( but i do not
think this is what causes this

> Not sure how to go about debugging this.
> 
> 
> Thanks for the help.
> 
> 
> -Tom
> 
> 
> -- 
> Thomas Moyer, Technical Staff voice: (781) 981-1374
> Cyber Systems Technology Group mobile: (857) 268-0493
> MIT Lincoln Laboratory email: thomas.moyer@ll.mit.edu
> 244 Wood Street
> Lexington, MA 02420



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
