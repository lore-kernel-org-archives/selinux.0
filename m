MIME-Version: 1.0
Sender: namhyung@gmail.com
In-Reply-To: <1719649.5PAcuqR8Pm@sifl>
References: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
 <1719649.5PAcuqR8Pm@sifl>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 19 Jun 2014 08:58:31 +0900
Message-ID: <CAM9d7cj07=ERVUnEhpCu6g72HsXCFSFmha8U6BZL6BbYBxckEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: simple cleanup for cond_read_node()
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, LKML <linux-kernel@vger.kernel.org>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Paul,

On Thu, Jun 19, 2014 at 4:36 AM, Paul Moore <paul@paul-moore.com> wrote:
> > @@ -402,19 +402,14 @@ static int cond_read_node(struct policydb *p, struct
>> cond_node *node, void *fp) int rc;
>>       struct cond_expr *expr = NULL, *last = NULL;
>>
>> -     rc = next_entry(buf, fp, sizeof(u32));
>> +     rc = next_entry(buf, fp, sizeof(buf));
>
> This is a bit nit-picky, but how about using "sizeof(u32) * 2"?  It is more
> consistent with the rest of the function and helps underscore that we are
> reading two 32-bit values.
>
> Assuming you're okay with the change I can fix it up when I apply the patch.

I'm okay with it. :)

Thanks,
Namhyung
