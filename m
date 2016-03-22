Subject: Re: [PATCH] selinux: fix memory leak on node_ptr on error return path
To: Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
References: <1458601213-5835-1-git-send-email-colin.king@canonical.com>
 <20160322202817.GA9459@mail.hallyn.com>
 <CAHC9VhThVmP14F_Eu3C=bBWPGkufFO5v9J0UFyeLFPLNW1FA7Q@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <56F1BB47.9070101@canonical.com>
Date: Tue, 22 Mar 2016 21:38:15 +0000
MIME-Version: 1.0
In-Reply-To: <CAHC9VhThVmP14F_Eu3C=bBWPGkufFO5v9J0UFyeLFPLNW1FA7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 22/03/16 21:35, Paul Moore wrote:
> On Tue, Mar 22, 2016 at 4:28 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> Quoting Colin King (colin.king@canonical.com):
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> node_ptr is not being free'd if the list allocation fails, fix
>>> this by kfree'ing it before exiting on the error path.
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Hi,
>>
>> I'm not very familiar with this code any more, but are you sure
>> this is needed and doesn't cause a new bug?  It *looks* like
>> the avtab_insert_nonunique() actually inserts the node_ptr
>> into the policydb, and the policydb is the one that should
>> eventually free it.
> 
> Exactly.  cond_insertf() calls avtab_insert_nonunique() which calls
> avtab_insert_node() which adds the node to the avtab.  The avtab will
> get cleaned up later by the error handling code in the cond_insertf()
> call chain.
> 
My bad, apologies.
