Subject: Re: [PATCH] Check return value of getexeccon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <200605021301.23810.glommer@br.ibm.com>
References: <200605021301.23810.glommer@br.ibm.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:50:39 -0400
Message-Id: <1147092639.23640.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 13:01 -0300, Glauber de Oliveira Costa wrote:
> getexeccon() , (and probably some other), may return NULL in it's return 
> argument. Currently, this is causing the interpreter to abort due to a failed 
> assertion. This patch adds a test in the argout typemap to fix this.

Thanks, merged as part of Dan's larger libselinux patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
