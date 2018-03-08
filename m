To: Nicolas Iooss <nicolas.iooss@m4x.org>, James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
 <20180305225820.23610-2-nicolas.iooss@m4x.org>
 <7c82f006-e291-ada6-a935-626436ccb156@tycho.nsa.gov>
 <CAJfZ7==1vF4AKuuoVFdtNRydbnQ5YT+8it7+mDcSOcUhfrs+Fg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5869eac8-fb14-2988-e78d-6f242b3690b7@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 16:28:46 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==1vF4AKuuoVFdtNRydbnQ5YT+8it7+mDcSOcUhfrs+Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re:  Re: [PATCH 2/3] libsepol: cil: show an error
 when cil_expr_to_string() fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/08/2018 03:42 PM, Nicolas Iooss wrote:
> On Tue, Mar 6, 2018 at 10:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 03/05/2018 05:58 PM, Nicolas Iooss wrote:
>>> cil_tree_print_expr() calls cil_expr_to_string() in order to compute a
>>> string expression into expr_str. If this function fails, expr_str is
>>> left unitialized but its value is dereferenced with:
>>>
>>>     cil_log(CIL_INFO, "%s)", expr_str);
>>>
>>> Prevent such an issue by checking cil_expr_to_string()'s return value
>>> before using expr_str.
>>>
>>> This issue has been found with clang's static analyzer.
>>>
>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>> ---
>>>  libsepol/cil/src/cil_tree.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
>>> index d36401b41dba..b394a9d849df 100644
>>> --- a/libsepol/cil/src/cil_tree.c
>>> +++ b/libsepol/cil/src/cil_tree.c
>>> @@ -503,15 +503,19 @@ exit:
>>>  void cil_tree_print_expr(struct cil_list *datum_expr, struct cil_list *str_expr)
>>>  {
>>>       char *expr_str;
>>> +     int rc;
>>>
>>>       cil_log(CIL_INFO, "(");
>>>
>>>       if (datum_expr != NULL) {
>>> -             cil_expr_to_string(datum_expr, &expr_str);
>>> +             rc = cil_expr_to_string(datum_expr, &expr_str);
>>>       } else {
>>> -             cil_expr_to_string(str_expr, &expr_str);
>>> +             rc = cil_expr_to_string(str_expr, &expr_str);
>>> +     }
>>> +     if (rc < 0) {
>>> +             cil_log(CIL_INFO, "ERROR)");
>>> +             return;
>>
>> Wondering if we should abort or return an error to the caller instead of just logging an error and returning?
> 
> I believe this depends on the usage of cil_tree_print_expr(). I have
> not found any caller of cil_tree_print_* outside of
> libsepol/cil/src/cil_tree.c so I guess this interface is only used by
> developers for debugging purpose when playing with libsepol's CIL
> objects (being able to quickly print an object in a human-readable
> form is a very valuable feature). Am I right? The current interface of
> ignoring all errors and logging as much as possible without aborting
> seems consistent with such a use-case.
> 
> If there is an interest in propagating errors found by
> cil_tree_print_expr() back to its callers, I can spend some time to
> clean up the code. Otherwise I will send other patches (once they are
> in a suitable state) to fix some issues that clang's static analyzer
> find.

You are correct, and James agreed with your approach, which is why I merged the patch as is.
