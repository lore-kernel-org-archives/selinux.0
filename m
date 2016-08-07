Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u77Iljwh003537
 for <selinux@tycho.nsa.gov>; Sun, 7 Aug 2016 14:47:45 -0400
Subject: Re: Should port 3269 be ldap_port_t?
To: Colin Powers <Colin.Powers@nexor.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <DB6PR0301MB2568DA47381B2C302EEC7D9F9E060@DB6PR0301MB2568.eurprd03.prod.outlook.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <5ed781ad-fc3b-db4f-56ac-9304545a3c58@ieee.org>
Date: Sun, 7 Aug 2016 14:47:41 -0400
MIME-Version: 1.0
In-Reply-To: <DB6PR0301MB2568DA47381B2C302EEC7D9F9E060@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/03/16 08:48, Colin Powers wrote:
> Hi all,
>
> First of all apologies if something has changed in this area recently, I have checked on a RHEL 7 machine and noticed the omission.
>
> LDAP is associated with the following ports:
> - 389 for plain LDAP
> - 686 for LDAPS
> - 3268 for Global Catalog
> - 3269 for Global Catalog over LDAPS
>
> All of these ports are ldap_port_t except 3269 which is not given any special type.
>
> Because of this, my Apache set-up was unable to perform LDAP authorisation while in enforcing. Obviously I can fix the issue with semanage, but should 3269 be ldap_port_t out of the box?

This type of question is more appropriate for the refpolicy list. 
However, I've added the port labeling in refpolicy.

-- 
Chris PeBenito
