Date: Wed, 8 Oct 2003 21:17:08 +0200
From: Tom <tom@lemuria.org>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: policy configuration problems
Message-ID: <20031008211705.F14104@lemuria.org>
References: <000e01c38dbb$d9841a60$5d38a8c0@lky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000e01c38dbb$d9841a60$5d38a8c0@lky>; from lky77@sjtu.edu.cn on Thu, Oct 09, 2003 at 12:47:22AM +0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 09, 2003 at 12:47:22AM +0800, lky wrote:
> Hi, I have installed 2.4-based SELinux on Redhat9.0 and I want to eliminate the denied messages now. But there are several problems about my policy configuration.
> First,there are still several system processes run within the initrc_t domain. I have moved up the .te files for these programes from the policy/domains/program/unused directory before building the policy and the pathname for these programs in the .fc files are right as well. Below is the 
> associated messages with the command "ps -e --context":

Check if the binaries are labelled correctly, i.e. do something like:

ls --context /usr/sbin/xinetd 
(or wherever it is installed in redhat)

it should be system_u:system_r:inetd_exec_t if I remember correctly. If
it's the generic :sbin_t then no transition happens.

same for the other programs.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
