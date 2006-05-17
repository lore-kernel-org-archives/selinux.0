From: Steve Grubb <sgrubb@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
Date: Wed, 17 May 2006 08:26:24 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
References: <446AFED3.9010800@redhat.com>
In-Reply-To: <446AFED3.9010800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605170826.24994.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 17 May 2006 06:45, Daniel J Walsh wrote:
> Basically check if the previous lookup was the same context, if yes
> return the same translation.   Otherwise do the lookup.

 hidden int
+fini_context_translations(void)
+{
+       free(prev_r2t_trans);
+       free(prev_r2t_raw);
+       free(prev_t2r_trans);
+       free(prev_t2r_raw);
+}
+

This function returns an int. sb return 0?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
