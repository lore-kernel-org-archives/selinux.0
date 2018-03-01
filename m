Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21B06ei010395
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 06:00:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E70440FB650
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:00:03 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2A610AF9F9
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:00:03 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu,  1 Mar 2018 11:59:42 +0100
Message-Id: <20180301105945.15587-1-vmojzis@redhat.com>
In-Reply-To: <aaa79052-e646-716d-676f-d06554953b3f@tycho.nsa.gov>
References: <aaa79052-e646-716d-676f-d06554953b3f@tycho.nsa.gov>
Subject: Re: [PATCH] gui/semanagePage: Close "edit" and "add"
 dialogues when successfull
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The traceback was caused by leaving the object class combo box blank (therefore is not directly connected to this patch).
But I agree that is's undesirable behavior. I can either add a check that would notify the user that they left the option blank, or set a default value.
