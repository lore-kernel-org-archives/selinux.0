Message-ID: <4F56CB36.7000700@windriver.com>
Date: Wed, 7 Mar 2012 10:43:02 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: allow default source/target selectors for user/role/range
References: <1331080128-26425-1-git-send-email-eparis@redhat.com>
In-Reply-To: <1331080128-26425-1-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 03/07/2012 08:28 AM, Eric Paris wrote:
> When new objects are created we have great and flexible rules to
> determine the type of the new object.

Shouldn't we introduce a default_type for class_datum as well? So far 
the process and various socket classes will inherit the creating 
process's domain, that is, DEFAULT_SOURCE as in your example, whilst for 
any other classes the type of the newly created object will follow the 
containing directory, that is, DEFAULT_TARGET.

Above logic has been hard-coded in security_compute_sid, which is a 
matter of policy and should be moved from security server to refpolicy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
