Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5ED1pMr006294
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 09:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03B8F15552
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 13:01:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE7878063C
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 13:01:25 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com
 (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E5BAD4BB74
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 13:01:25 +0000 (UTC)
Date: Wed, 14 Jun 2017 09:01:25 -0400 (EDT)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
In-Reply-To: <2119186821.22847633.1497445251447.JavaMail.zimbra@redhat.com>
Subject: Collecting ideas for audit2allow improvement
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I would like to improve SELinux audit2allow tool as my bachelor thesis.
I collected ideas from my colleagues from RedHat SELinux team and I would also
like to hear your ideas - what would you improve to make audit2allow smarter or
easier to use.

Ideas collected so far:

  * offer dac_read_search when sufficient instead of dac_override
    (see <https://github.com/SELinuxProject/selinux/issues/31>)
  * offer multiple solutions to a problem (example: 1) add allow rule for
    execute + execute_no_trans or 2) add allow rule for execute
    + type_transition rule)
  * interactive mode: ask questions and choose best solution
  * warn when solution touches trusted computing base (rules you should not be
    adding)
  * suggest alternate labels for content, example: httpd_t not allowed to write
    to user_home_t, might suggest that changing the label to
    httpd_user_content_t
  * output to CIL (add option for this)
  * if the AVC talks about execute permission then offer also type_transition
    rule
  * idea for a tool for automatic policy generation: On a test system you
    install application, turn the SELinux to permissive and run a full test
    suit. You collect all the AVCs in say Elasticsearch (can use common logging
    ViaQ project for that) and then there is a tool that searches the AVC,
    groups them and creates a policy out of them.
  * add option to open bugzilla
  * output to Ansible playbook/role task (add option for this)

I would also like to know which feature would you appreciate the most.

Thanks

Jan Zarsky
