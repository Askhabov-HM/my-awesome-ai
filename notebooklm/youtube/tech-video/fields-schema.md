## Metadata schema (YAML)

```yaml
source: string            # LLM / you        e.g. youtube
url: string               # LLM              e.g. https://www.youtube.com/watch?v=...
video_id: string          # LLM              e.g. a1b2c3d4
title: string             # LLM              e.g. Kubernetes Ingress deep dive
channel: string           # LLM              e.g. SomeTechChannel
published_at: date|string # LLM (if possible) e.g. 2025-11-02
watched_at: date|string   # LLM / you        e.g. 2026-02-14
duration_min: number|string # LLM            e.g. 74
type: enum                # LLM              e.g. lecture
tags: list[string]        # LLM              e.g. [k8s, networking]
topics: list[string]      # LLM              e.g. [ingress, tls, routing]
status: enum              # you              e.g. reviewed
usefulness: number        # you              e.g. 5
```