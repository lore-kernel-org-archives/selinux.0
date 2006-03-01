Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k219WOb5010505
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 04:32:24 -0500
Received: from xproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k219Us1o004283
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 09:30:54 GMT
Received: by xproxy.gmail.com with SMTP id s14so56890wxc
        for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2006 01:32:23 -0800 (PST)
Message-ID: <4ef5fec60603010132t62429e2eqf0339774b7fc6d2d@mail.gmail.com>
Date: Wed, 1 Mar 2006 01:32:23 -0800
From: coderman <coderman@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: virtual SELinux appliances, automated test suites
In-Reply-To: <4ef5fec60602281726j2895cdcfwdc10696c1c081560@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4ef5fec60602281726j2895cdcfwdc10696c1c081560@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/28/06, coderman <coderman@gmail.com> wrote:
> ...
> the way in which we are using virtual appliances requires the OS
> images be pre-populated with all necessary keys, configuration, and
> application data.  this places an emphasis on testing to ensure
> mastered os instances / appliances function as desired standalone or
> within a network.  information related to automated regression
> testing, learning modes for SELinux policy definition/refinement, and
> other relevant resources would be greatly appreciated.

it might be helpful to mention existing systems for policy generation
and testing, and OS/application testing with these policies. 
comparisons and commentary regarding real world use, lessons learned,
etc is solicited.

relevant conversations and details from the symposium would also be appreciated.

policy management/generation:
- reference policy (everyone knows about it; listed for completeness)
 [ http://serefpolicy.sourceforge.net/api-docs/ ]

- setools, policycoreutils, audit2allow, audit2ref, apol
  [ http://selinux.sourceforge.net/devel/userland.php3
   http://www.tresys.com/selinux/selinux_policy_tools.shtml ]

- slat, polgen
  [ http://www.mitre.org/tech/selinux/ ]

- selinux policy editor (and accompanying simplified policy language)
 [ http://seedit.sourceforge.net/ ]

- selpec, sellog, selchk
  [ http://www.selinux.hitachi-sk.co.jp/en/tool/selaid/selaid-top.html ]

- SLIDE (eclipse plugin, not useful standalone / console?)
  [ http://selinux-ide.sourceforge.net/index.php ]

- CDS Framework IDE (no standalone/console mode?)
  [ http://tresys.com/selinux/cds_framework.shtml ]

- SELinux Policy Server
  [ http://tresys.com/selinux/selinux_policy_server.shtml ]

- conditional policy extension
 [ http://tresys.com/files/docs/cond-readme.txt ]

- Lopol: A Deductive Database Approach to Policy Analysis and Rewriting
 [ nothing public at this time? ]

- CIPSO / IPsec policy hooks / SELinux Protected Paths
 [ nothing public at this time? ]

- SENG: An Enhanced Policy Language for SELinux
 [ nothing public at this time? ]



OS/Application level testing / automation:
- Linux Test Project / selinux-testsuite
 [ http://ltp.sourceforge.net/
   limited mainly to testing selinux kernel capabilities? ]

- Towards Automated Authorization Policy Enforcement
 [ nothing public at this time? ]

- Software Testing Automation Framework / STAX
 [ http://staf.sourceforge.net/index.php ]

- Other test tools?
 [ http://ltp.sourceforge.net/tooltable.php ]


regarding SELinux within or hosting virtual OS instances i am still
interested in any projects / experiences using the xen hypervisor
specifically: http://www.xensource.com/

best regards,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
