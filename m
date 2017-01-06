Subject: Re: [PATCH 4/5] checkpolicy: do not leak queue elements in
 queue_destroy()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
 <20161226211832.7165-4-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <9a4ed6fc-6f8b-32a8-3735-86f1a0d8ec27@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:27:53 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211832.7165-4-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:18 PM, Nicolas Iooss wrote:
> Elements which are inserted into a queue_t object are either NULL (from
> insert_separator()) or strings allocated with malloc() in insert_id().
> They would be freed if there are still present in the queue when it is
> destroyed. Otherwise the memory allocated for these elements would be
> leaked.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  checkpolicy/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
> index 272079c0debe..acc991c63303 100644
> --- a/checkpolicy/queue.c
> +++ b/checkpolicy/queue.c
> @@ -113,6 +113,7 @@ void queue_destroy(queue_t q)
>
>  	p = q->head;
>  	while (p != NULL) {
> +		free(p->element);
>  		temp = p;
>  		p = p->next;
>  		free(temp);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
