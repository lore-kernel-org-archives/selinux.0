Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v222TSLW001377
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 21:29:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65FF5C057FAC
 for <selinux@tycho.nsa.gov>; Thu,  2 Mar 2017 02:29:27 +0000 (UTC)
Received: from dhcp-40-5.bne.redhat.com (ovpn-116-20.sin2.redhat.com
 [10.67.116.20])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 v222TL4A009928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 21:29:26 -0500
To: selinux@tycho.nsa.gov
From: Doug Brown <dgbrown@redhat.com>
Subject: seapply - alternative to semanage for configuration management
Message-ID: <744a0953-a3a5-ad1a-aa47-889829c39be9@redhat.com>
Date: Thu, 2 Mar 2017 12:29:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,

Some SELinux configurations can't be included in policy and require the
use of semanage. This is fine in some cases, such as the installation of
services by package management, but the use of `semanage -i` doesn't
lend itself well to applying and enforcing certain local changes (e.g.
RBAC mappings) using configuration management tools (Ansible, puppet, etc.).

To address this, I've created a new command 'seapply'
(https://github.com/doksu/seapply), which takes a JSON representation of
the desired configuration and compares it to the local running
configuration. Iff discrepancies exist, it rectifies those specific
differences. In this way, a configuration management tool can run the
seapply command frequently without reapplying all the local SELinux
configuration customisations each time (which significantly slows down
the application of configuration management policies).

Any suggestions or feedback? Would it be possible to bring this into the
tool set?

Cheers,
Doug
